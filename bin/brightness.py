#!/usr/bin/env python3
# claude slop
"""
Brightness control script for two monitors with different calibration curves.
Usage: brightness.py up | down
"""

import sys
import subprocess
from pathlib import Path

# Calibration points: (monitor1_value, monitor2_value)
CALIBRATION_POINTS = [
    (0, 30),
    (10, 60),
    (35, 90),
    (45, 100),
]

NUM_STOPS = 9  # Gives clean indices 0-8

STATE_FILE = Path("~/.local/state/brightness_stop").expanduser()


def interpolate_monitors(num_stops: int) -> list[tuple[int, int]]:
    """Generate interpolated brightness stops for both monitors."""
    # Extract separate curves
    m1_points = [p[0] for p in CALIBRATION_POINTS]
    m2_points = [p[1] for p in CALIBRATION_POINTS]

    # Evenly spaced t values across calibration points
    num_cal = len(CALIBRATION_POINTS)
    cal_t = [i / (num_cal - 1) for i in range(num_cal)]

    stops = []
    for i in range(num_stops):
        t = i / (num_stops - 1)

        # Find which segment t falls in and interpolate
        def interp(points):
            for j in range(len(cal_t) - 1):
                if t <= cal_t[j + 1]:
                    seg_t = (t - cal_t[j]) / (cal_t[j + 1] - cal_t[j])
                    return round(points[j] + seg_t * (points[j + 1] - points[j]))
            return points[-1]

        stops.append((interp(m1_points), interp(m2_points)))

    return stops


STOPS = interpolate_monitors(NUM_STOPS)


def read_stop() -> int:
    try:
        return int(STATE_FILE.read_text().strip())
    except (FileNotFoundError, ValueError):
        return len(STOPS) // 2  # Default to middle


def write_stop(stop: int) -> None:
    STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
    STATE_FILE.write_text(str(stop))


def set_brightness(m1: int, m2: int) -> None:
    for display, value in ((1, m1), (2, m2)):
        subprocess.Popen(
            ["ddcutil", "-d", str(display), "setvcp", "10", str(value)],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )


def main():
    if len(sys.argv) != 2 or sys.argv[1] not in ("up", "down"):
        print(f"Usage: {sys.argv[0]} up | down", file=sys.stderr)
        print("\nConfigured stops (m1, m2):")
        for i, (m1, m2) in enumerate(STOPS):
            print(f"  {i}: ({m1:3d}, {m2:3d})")
        sys.exit(1)

    direction = sys.argv[1]
    current = read_stop()

    if direction == "up":
        new_stop = min(current + 1, len(STOPS) - 1)
    else:
        new_stop = max(current - 1, 0)

    if new_stop == current:
        print(
            f"Already at {'maximum' if direction == 'up' else 'minimum'} brightness (stop {current})"
        )
        sys.exit(0)

    m1, m2 = STOPS[new_stop]

    # Write target state immediately (reentrant) then debounce:
    # sleep briefly and only call ddcutil if no newer invocation has
    # superseded us (i.e. the file still holds the value we wrote).
    write_stop(new_stop)

    import time

    time.sleep(0.25)

    if read_stop() != new_stop:
        # A later invocation has already taken over — let it handle ddcutil.
        print("Cancelled")
        sys.exit(0)

    set_brightness(m1, m2)

    print(f"Stop {new_stop}/{len(STOPS) - 1}: monitor1={m1}, monitor2={m2}")


if __name__ == "__main__":
    main()
