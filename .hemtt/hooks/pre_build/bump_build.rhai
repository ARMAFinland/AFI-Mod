// Auto-increments the BUILD number in script_version.hpp on every `hemtt build`/`hemtt release`.
// Uses the real file system (not HEMTT_VFS) so the new number is persisted to disk.
let path = HEMTT_RFS.join("addons/main/script_version.hpp");
let content = path.open_file().read();

let marker = "#define BUILD ";
let start = content.index_of(marker) + marker.len();
let end = content.index_of("\n", start);
let current = parse_int(content.sub_string(start, end - start));
let next = current + 1;

let updated = content.sub_string(0, start) + next.to_string() + content.sub_string(end);
path.create_file().write(updated);

print("Bumped BUILD number to " + next);
