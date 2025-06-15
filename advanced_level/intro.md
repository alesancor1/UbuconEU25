Welcome! In this hands-on scenario, you'll learn how to create and evolve a secure, containerized NGINX web server using **[Rockcraft](https://ubuntu.com/rockcraft)**, a tool for building OCI-compliant container images from declarative YAML.

You’ll start simple and progressively add capabilities, ending with a **rootless, HTTPS-enabled rock** ready for local testing or further development.

---

## 🧰 What You'll Be Doing

You'll build a custom **NGINX-based rock**, starting with just a static HTML file and ending with HTTPS support and improved container security.

Here's what each step will cover:

### 🔹 Step 1: Add Sources to a Rock
You'll create a `rockcraft.yaml` that adds a simple `index.html` file to your container. This helps you learn how Rockcraft handles source files and parts.

### 🔹 Step 2: Install and Configure NGINX
Next, you’ll install **NGINX**, configure it to serve your static content, and optionally:
- Use **Chisel slices** to slim down your rock
- Make the rock **baseless** to reduce the attack surface

### 🔹 Step 3: Make the Rock Rootless
Running containers as `root` is risky. In this step, you’ll update your rock to run as a **non-root user**, using Rockcraft’s built-in `_daemon_` user and adjusting file permissions as needed.

### 🔹 Step 4: Add HTTPS Support with TLS Certs
Finally, you'll build [**minica**](https://github.com/jsha/minica) from source to generate **self-signed certificates**, and configure NGINX to serve content over **HTTPS**. Great for local testing!

---

## 🛠️ Your Environment is Ready

This environment comes pre-configured with everything you need:

- ✅ `rockcraft` is **already installed**
- ✅ `lxd` is initialized and ready for builds
- ✅ A handy **alias** for loading rocks into Docker is set:

```bash
skopeo-copy <rock-file>
```

This will copy your built `.rock` file directly into the local Docker daemon for testing.

---

## 🧑‍💻 Let’s Build Some Rocks!

Click "Start" to begin with Step 1, and watch your custom container evolve from a static HTML server to a secure HTTPS-enabled web service—all with Rockcraft.
