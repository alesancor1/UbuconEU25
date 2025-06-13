# Chisel the Rock

In this step, you’ll modify your `rock.yaml` to use a **chisel slice** instead of directly including the full `hello` package. This makes your rock smaller and more efficient by including only the exact files you need.

## 🧱 What Is a Chisel Slice?

A **chisel slice** is a pre-defined subset of files from a package—just enough to make something work. Instead of installing the entire `hello` package, you can include just the minimal files it needs by referencing the correct chisel slice.

This helps reduce the size of your rock and keeps it more secure and focused.

---

## 📝 Instructions

Your current `rock.yaml` includes this:

```yaml
stage-packages:
  - hello
```

Your task is to replace that with the equivalent **chisel slice**. You'll do this by:

1. Searching for the `hello.yaml` slice definition file (SDF) in chisel releases (see next section).
2. Replacing the `hello` package by the correct slice found in the SDF.

---

## 🧰 Where to Find Chisel Slices

You can browse all available chisel slices at:

📂 **https://github.com/canonical/chisel-releases**

- Each Ubuntu release has its own **branch** (e.g., `24.04`).
- Inside each branch, you'll find a `/slices` directory.
- Look for a package SDF to see what slices it contains.

---

You can use `nano` or any other text editor to modify the rock file.
