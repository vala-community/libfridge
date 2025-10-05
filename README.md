# libfridge

Simple Vala App Storage Library

## Build Instructions

First, setup the build directory by running the following command in the project root:

```
meson setup build --prefix=/usr
```

Now change to the `build` directory (`cd build`) for the following commands:

Build libfridge:

```
ninja
```

To install libfridge:

```
ninja install
```

## Documentation

By default, documentation is built by default using [`valadoc`](https://docs.vala.dev/developer-guides/documentation/valadoc-guide.html)

If you would not like to generate documentation for this project, pass the additional `-Denable_valadoc=false` flag to meson then run `ninja` as before.

If you haven't created the build directory, in the project root run:

```
meson setup build --prefix=/usr -Denable_valadoc=false
```

However, if you have already created the build directory, you can run the following command inside the build directory:

```
meson configure -Denable_valadoc=false
```

To enable valadoc documentation generation again, perform the same commands again but replace `false` in `-Denable_valadoc=` with `true`.
