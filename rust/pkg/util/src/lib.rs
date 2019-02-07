pub fn data_file(s: &str) -> std::path::PathBuf {
    std::env::current_exe()
        .expect("No executable path?")
        .as_path()
        .ancestors()
        .skip(4)
        .next()
        .unwrap()
        .join("data")
        .join(s)
}
