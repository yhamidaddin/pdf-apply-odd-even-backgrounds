#!/bin/bash

# ================================
# PDF Background Stamping Script
# ================================
# This script applies background stamps to the pages of a PDF document.
# - It can stamp odd and even pages separately.
# - It can stamp all pages with the same background.
#
# Usage:
# ./script.sh [DOCUMENT_PDF] [ODD_BACKGROUND_PDF] [EVEN_BACKGROUND_PDF]
#
# Options:
#  - DOCUMENT_PDF: The PDF document to be stamped.
#  - ODD_BACKGROUND_PDF: Background for odd pages (if using two stamps).
#  - EVEN_BACKGROUND_PDF: Background for even pages (if using two stamps).
# Author         :Yahya Hamidaddin
# Email          :yhamidaddin@open-alt.com
# License       : GNU GPL-3
# ================================

# Function to show help message
show_help() {
  echo "Usage: $0 [DOCUMENT_PDF] [ODD_BACKGROUND_PDF] [EVEN_BACKGROUND_PDF]"
  echo
  echo "This script applies background stamps to the pages of a PDF."
  echo
  echo "Options:"
  echo "  [DOCUMENT_PDF]        The input PDF document to be stamped."
  echo "  [ODD_BACKGROUND_PDF]  The PDF background to apply to the odd pages."
  echo "  [EVEN_BACKGROUND_PDF] The PDF background to apply to the even pages."
  echo
  echo "If only two arguments are given, the second file is used as a stamp for all pages."
  echo "If no arguments are given, the script will prompt for user input."
}

# Function to apply a single background stamp to a PDF
apply_single_stamp() {
  local input_pdf=$1
  local background_pdf=$2
  echo "Applying the background stamp to all pages..."
  pdftk "$input_pdf" multistamp "$background_pdf" output final-document.pdf
  echo "Process complete. The final PDF is: final-document.pdf"
}

# Function to apply different background stamps for odd and even pages
apply_odd_even_stamps() {
  local input_pdf=$1
  local odd_background=$2
  local even_background=$3

  # Split the input PDF into odd and even pages
  echo "Splitting the input PDF into odd and even pages..."
  pdftk "$input_pdf" cat 1-endodd output odd-pages.pdf
  pdftk "$input_pdf" cat 1-endeven output even-pages.pdf

  # Apply the background stamps to odd and even pages
  echo "Applying the odd page background stamp..."
  pdftk odd-pages.pdf multistamp "$odd_background" output odd-pages-stamped.pdf
  echo "Applying the even page background stamp..."
  pdftk even-pages.pdf multistamp "$even_background" output even-pages-stamped.pdf

  # Recombine the odd and even pages with the background stamps
  echo "Merging odd and even pages with the background stamps..."
  pdftk A=odd-pages-stamped.pdf B=even-pages-stamped.pdf shuffle A B output final-document.pdf

  # Clean up temporary files
  echo "Cleaning up temporary files..."
  for temp_file in odd-pages.pdf even-pages.pdf odd-pages-stamped.pdf even-pages-stamped.pdf; do
    if [[ -f "$temp_file" ]]; then
      rm -f "$temp_file"
    fi
  done

  echo "Process complete. The final PDF is: final-document.pdf"
}

# ================================
# Main Script Logic
# ================================

# Check for help option
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
  show_help
  exit 0
fi

# Check for number of arguments
if [ $# -eq 3 ]; then
  # Case 1: Three arguments, we have both odd and even stamps
  input_pdf=$1
  odd_background=$2
  even_background=$3

  # Confirm action with the user
  echo "You are about to apply the following stamps:"
  echo "  - Odd pages will be stamped with: $odd_background"
  echo "  - Even pages will be stamped with: $even_background"
  echo "This will be applied on: $input_pdf"
  read -p "Do you want to proceed? (y/n): " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
  fi

  # Apply odd and even page background stamps
  apply_odd_even_stamps "$input_pdf" "$odd_background" "$even_background"

elif [ $# -eq 2 ]; then
  # Case 2: Two arguments, the second one is used as a stamp for all pages
  input_pdf=$1
  background_pdf=$2

  # Confirm action with the user
  echo "You are about to apply the following background stamp to all pages of $input_pdf:"
  echo "  - Background stamp: $background_pdf"
  read -p "Do you want to proceed? (y/n): " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Operation cancelled."
    exit 0
  fi

  # Apply the background stamp to all pages
  apply_single_stamp "$input_pdf" "$background_pdf"

else
  # Case 3: No arguments, prompt the user for input
  read -p "Enter the input PDF filename (e.g., my-document.pdf): " input_pdf

  echo "Do you want to apply one stamp for all pages or separate stamps for odd and even pages?"
  echo "1) Apply one stamp to all pages"
  echo "2) Apply different stamps to odd and even pages"
  read -p "Choose option 1 or 2: " choice

  if [ "$choice" -eq 1 ]; then
    # Option 1: One stamp for all pages
    read -p "Enter the background PDF to apply to all pages: " background_pdf
    # Confirm action with the user
    echo "You are about to apply the following background stamp to all pages:"
    echo "  - Background stamp: $background_pdf"
    read -p "Do you want to proceed? (y/n): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
      echo "Operation cancelled."
      exit 0
    fi

    # Apply the stamp to all pages
    apply_single_stamp "$input_pdf" "$background_pdf"

  elif [ "$choice" -eq 2 ]; then
    # Option 2: Different stamps for odd and even pages
    read -p "Enter the odd page background PDF: " odd_background
    read -p "Enter the even page background PDF: " even_background

    # Confirm action with the user
    echo "You are about to apply the following stamps:"
    echo "  - Odd pages will be stamped with: $odd_background"
    echo "  - Even pages will be stamped with: $even_background"
    read -p "Do you want to proceed? (y/n): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
      echo "Operation cancelled."
      exit 0
    fi

    # Apply odd and even page background stamps
    apply_odd_even_stamps "$input_pdf" "$odd_background" "$even_background"

  else
    echo "Invalid choice. Exiting."
    exit 1
  fi
fi
