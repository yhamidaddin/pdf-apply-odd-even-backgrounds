### README for `PDF Background Stamping Script`

```markdown
# PDF Background Stamping Script

This script allows you to apply background stamps to the pages of a PDF
document. You can apply a single background to all pages or apply different
backgrounds to odd and even pages. It uses `pdftk`, a popular tool for
manipulating PDF files, to apply these background stamps.

## Table of Contents
- [Overview](#overview)
- [Usage](#usage)
  - [Command-Line Arguments](#command-line-arguments)
  - [Interactive Mode](#interactive-mode)
- [Requirements](#requirements)
- [License](#license)
- [Contact](#contact)

## Overview

The `PDF Background Stamping Script` is designed to add background stamps to
a PDF document. It offers flexibility by allowing:
- **One background for all pages** or 
- **Separate backgrounds for odd and even pages**.

It ensures that the process is smooth by allowing the user to confirm the operation before
it runs, preventing accidental mistakes.

### Features
- Stamp **odd and even pages separately** with different backgrounds.
- **Single background** for all pages.
- **Confirmation** before executing any operation.
- **Interactive mode** if no arguments are passed, asking the user for input.

## Usage

### Command-Line Arguments

You can run the script with three command-line arguments, where:
1. `[DOCUMENT_PDF]`: The PDF file to which you want to apply background stamps.
2. `[ODD_BACKGROUND_PDF]`: The background PDF to apply to odd pages (if using separate stamps 
for odd and even pages).
3. `[EVEN_BACKGROUND_PDF]`: The background PDF to apply to even pages (if using separate stamps
 for odd and even pages).

To apply a single background for all pages, you can provide only two arguments, where the second
one is used as the background for all pages.

#### Example Usage:

- **Apply one background to all pages**:
  ```bash
  ./script.sh input.pdf odd-even-background.pdf
  ```

- **Apply different backgrounds to odd and even pages**:
  ```bash
  ./script.sh input.pdf odd-background.pdf even-background.pdf
  ```

### Interactive Mode

If no arguments are passed, the script will prompt you for input to guide you through the 
process interactively.

#### Example:

```bash
./script.sh
```

1. **Step 1**: Input the PDF filename.
2. **Step 2**: Choose whether to apply one stamp to all pages or separate 
stamps for odd and even pages.
3. **Step 3**: Provide the background PDF(s) based on your selection.

### Help Option

You can view the help message with the following command:

```bash
./script.sh --help
```

## Requirements

This script requires the `pdftk` tool to manipulate the PDF files. You can install `pdftk` on 
various Linux distributions using the following commands:

- **Ubuntu/Debian**:
  ```bash
  sudo apt-get install pdftk
  ```

- **Fedora**:
  ```bash
  sudo dnf install pdftk
  ```

- **Arch Linux**:
  ```bash
  sudo pacman -S pdftk
  ```

## License

This script is licensed under the **GNU GPL-3**. You can freely modify and distribute it under 
the terms of this license.

## Contact

- **Author**: Yahya Hamidaddin
- **Email**: [yhamidaddin@open-alt.com](mailto:yhamidaddin@open-alt.com)

```
