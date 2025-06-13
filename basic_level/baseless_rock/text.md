In this step, you'll modify your `rockcraft.yaml` to make the rock **baseless**. This allows you to create leaner container images with fewer dependencies by using only what you explicitly include.

## 📝 Instructions

Your current `rockcraft.yaml` uses a full base image:

```yaml
base: ubuntu@24.04
```

To make your rock **baseless**, you’ll need to:

1. **Change the `base` to a special keyword** that means no base will be included at runtime.
2. **Add a `build-base` field** that tells the builder which environment to use during the build step.

---

You can use `nano` or any other text editor to modify the rock file.