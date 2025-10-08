# libfridge

A simple, hassle-free storage library to keep your data fresh.
Ready out of the box, and comprehensive for vala newcomers. This library primarily contains the three following objects:

- json_storage
- string_storage
- byte_storage

all three are meant to represent a storage file saved on the disk
Simply declare:

```
var mystorage = new Fridge.json_storage();
```

Or any variant depending what you want to store... And you are good to go! 
Access mystorage.content, or assign it, to load and save. There are more options for more control, but the idea here is to set and forget.



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
