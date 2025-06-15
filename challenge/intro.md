You’ve walked through every stage of building and securing a containerized service using **Rockcraft**—from static file packaging to HTTPS, rootless operation, and even building software from source.

Now, it’s your turn to apply everything you've learned... and push it even further.

---

## 🧠 What’s This Challenge About?

This is an **open-ended challenge** where you'll:

- Build a rock of **your own choice**
- Apply best practices you learned previously
- Explore new features by reading the docs
- Think beyond a single rock—maybe add multiple versions, documentation, or CI workflows

This is your opportunity to take what you've practiced and create something **production-ready**, shareable, or just fun.

---

## 🧪 About This Playground

This Killercoda environment is a **temporary playground** great for prototyping and experimentation.  
However, we encourage you to complete this challenge on **your own machine** to experience the full Rockcraft development workflow and iterate more easily.

---

## ⚙️ Setup the Environment Locally

To do this challenge properly on your system, make sure you have:

1. **Snapd installed**  

```bash
sudo apt install -y snapd
```

2. **Rockcraft installed**  

```bash
sudo snap install rockcraft --classic
```

3. **LXD initialized**  

```bash
sudo lxd init --auto
```

4. **Docker installed** (optional, for testing)  

```bash
sudo snap install docker
```

5. (Optional) Add this function to your `.bashrc` file:

```bash
skopeo-copy() {
    short_name=$(echo "$1" | cut -d '_' -f1)
    short_version=$(echo "$1" | cut -d '_' -f2)
    sudo rockcraft.skopeo --insecure-policy copy oci-archive:"$1" docker-daemon:"$short_name":"$short_version"
}
```

---

## 🧑‍💻 Let’s Rock

Ready to take the training wheels off and ship something cool?

Go to the next section to see your challenge.
