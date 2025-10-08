/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText:  2025 Stella & Charlie (teamcons.carrd.co)
 */

/**
* A library intended for basic storage, for beginner and whoever needs only hassle-free basics
* 
* Json_storage represents a json file in the app's data folder
* You can use this class to store a Json.Array containing your objects (As Json.Node)
* You can optionally initialize it with with a file name
* 
*/
public class Fridge.json_storage : Object {

    /**
    * Used to give a unique name for each new instance without file name
    * Incremented during object creation, only when no argument has been passed
    */
    private static uint8 unnamed_storage_count = 0;

    /**
    * This signal gets emitted when the content of the storage has been changed
    * This allows you to connect to your storage instance and trigger a function whenever there has been changes
    */
    public signal void changed ();

    /**
    * This signal gets emitted when there is an error while loading or saving, along with said error
    * Connect to this if you wish to handle errors
    */
    public signal void error (Error e);

    /**
    * Whether to keep a duplicate of the storage content to access storage very quickly 
    * By default this is set to true. Cache is regenerated when saving, and when loading if empty and enabled
    * You can force it to be reloaded by using empty_cache, then accessing the storage content
    * This feature can be disabled anytime, but make sure to call empty_cache after disabling it to avoid keeping a stale cache in memory
    */
    public bool keep_cache = true;

    /**
    * A copy of the storage file content.
    */
    private Json.Array? cache;

    /**
    * The name of the file saved on disk. This can be set only upon creation
    * Should there be no name, a default one will be assigned
    */
    string filename { public get; private set;}

    /**
    * The path of the directory where the storage file is saved
    * This variable is not meant to be changed, and only as aid if the location is uncertain
    */
    string data_directory { public get; private set;}

    /**
    * The full path of the storage file
    * This variable is not meant to be changed, and only as aid if the location is uncertain
    */
    string storage_path { public get; private set;}

    /**
    * Create a representation of a storage file. If there is no file, the storage is considered empty
    * There is one optional parameters:
    * 
    * name: the name of the file to save to and load from. By default it is simply "storage.json"
    * 
    * the storage emits a changed() signal whenever 
    */
    public json_storage (string? name =  "") {
        Object (filename: name);
    }

    /**
    * Property representing the content of storage on disk
    * You can save a Json.Array by invoking:
    *   
    *   yourstorageinstance.content = array;
    *    
    * And load the content of the file by doing
    *    
    *   var array = yourstorageinstance.content;
    *    
    * You can disable the cache via keep_cache = false
    * You can connect handlers to the storage via the changed() signal
    * If you expect errors to happen, connect a handler to error() signal
    */
    public Json.Array? content {
        owned get { return load ();}
        set { save (value);}
    }

    /*************************************************/
    construct {

        // Allow having several storage files without declaring a single name
        // Each get a unique number depending on the order it is declared
        // If the order is the same each time, there wouldnt be any storage clash
        if (filename == "") {
            filename = "storage_%i.json".printf (unnamed_storage_count);
            unnamed_storage_count += 1;
        }

        data_directory = Environment.get_user_data_dir ();
        storage_path = data_directory + "/" + filename;
        check_if_datadir ();
    }

    /*************************************************/
    /**
    * Persistently check for the data directory and create if there is none
    * Without this, we risk creating our storage in the void
    */
    private void check_if_datadir () {
        debug ("[STORAGE] do we have a data directory?");
        var dir = File.new_for_path (data_directory);

        try {
			if (!dir.query_exists ()) {
				dir.make_directory ();
				debug ("[STORAGE] yes we do now");
			}
		} catch (Error e) {
			warning ("[STORAGE] Failed to prepare target data directory: %s\n", e.message);
		}
	}

    /*************************************************/
    /**
    * Converts a Json.Node into a string and take care of saving it
    */
    private void save (Json.Array? json_data) {
        debug("[STORAGE] Writing...");
        check_if_datadir ();

        try {
            var generator = new Json.Generator ();
            var node = new Json.Node (Json.NodeType.ARRAY);
            node.set_array (json_data);
            generator.set_root (node);
            generator.to_file (storage_path);
            if (keep_cache) { cache = json_data;};
            changed ();

        } catch (Error e) {
            warning ("[STORAGE] Failed to save to storage: %s", e.message);
            error (e);
        }
    }

    /*************************************************/
    /**
    * Grab from storage, into a Json.Node we can parse. Insist if necessary
    * We simply return a copy of the cache in the event we track one and it isn't empty
    * Should the storage be empty, and thus the cache as well, we still check on-disk
    */
    private unowned Json.Array? load () {
        debug("[STORAGE] Loading from storage letsgo");
        check_if_datadir ();

        if (keep_cache && (cache != null)) {
            return cache.copy ();
        }

        var parser = new Json.Parser ();
        var array? = new Json.Array ();

        try {
            parser.load_from_mapped_file (storage_path);
            var node = parser.get_root ();
            array = node.get_array ();
            if (keep_cache) { cache = json_data;};

        } catch (Error e) {
            warning ("[STORAGE] Failed to load from storage: " + e.message.to_string());
            error (e);
        }

        return array;
    }
    
    
    /*************************************************/
    /**
    * Drop everything. The next time the content property is accessed, it will be read from disk
    * If keep_cache is set to true, a new cache will be generated
    */
    private void empty_cache () {
        debug("[STORAGE] Emptying cache");
        cache = null;
    }
}
