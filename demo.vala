// Testing and demo purposes
// valac --pkg libfridge demo.vala

  public static int main (string[] args) {

    var sto = new Fridge.string_storage ();
    print ("\n" + "Location: " + sto.storage_path + "\n");

    switch (args[1]) {
      case "load": print (sto.content);break;
      case "save": sto.content = args[2];break;
      default: ;break;
    }

    return 0;
  }
