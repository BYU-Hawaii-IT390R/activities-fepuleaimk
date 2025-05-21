from pathlib import Path
import argparse

def scan_txt_files(directory, min_size_kb):
    directory = Path(directory)
    if not directory.exists():
        print("Directory does not exist.")
        return

    txt_files = list(directory.rglob("*.txt"))

    print(f"\nScanning: {directory.resolve()}")
    print(f"Applying minimum size filter: {min_size_kb} KB")
    
    # Filter files by size
    filtered_files = [f for f in txt_files if f.stat().st_size / 1024 > min_size_kb]

    print(f"Found {len(filtered_files)} text files larger than {min_size_kb} KB:\n")
    print(f"{'File':<40} {'Size (KB)':>10}")
    print("-" * 52)

    total_size = 0
    for file in filtered_files:
        size_kb = file.stat().st_size / 1024
        total_size += size_kb
        print(f"{str(file.relative_to(directory)):<40} {size_kb:>10.1f}")

    print("-" * 52)
    print(f"Total size: {total_size:.1f} KB\n")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Recursively scan directory for .txt files.")
    parser.add_argument("path", help="Path to directory to scan")
    parser.add_argument("--min-size", type=float, default=0,
                        help="Minimum file size in KB to include (default: 0)")
    args = parser.parse_args()
    scan_txt_files(args.path, args.min_size)
