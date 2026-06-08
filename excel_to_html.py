import os
import sys
import subprocess
from pathlib import Path

ROOT_DIR = sys.argv[1]

def convert_excel_to_html(excel_path: Path):
    try:
        subprocess.run(
            [
                "soffice",
                "--headless",
                "--convert-to", "html",
                str(excel_path),
                "--outdir", str(excel_path.parent)
            ],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.PIPE,
            text=True
        )

        print(f"✓ {excel_path}")

    except subprocess.CalledProcessError as e:
        print(f"✗ {excel_path}")
        print(e.stderr)

def main():
    for ext in ("*.xlsx", "*.xls", "*.xlsm"):
        for excel_file in Path(ROOT_DIR).rglob(ext):
            convert_excel_to_html(excel_file)

if __name__ == "__main__":
    main()