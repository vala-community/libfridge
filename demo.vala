// Testing and demo purposes
// valac --pkg libfridge demo.vala

  public static int main (string[] args) {

    sto = new Fridge.string_storage ();
    print ("\n" + "Location: " sto.storage_path + "\n")

    switch (args[1]) {
      "load": print(sto.content);break;
      "save":  sto.content = args[2];break;
      default: ;break;
    }

    return 0;
  }
