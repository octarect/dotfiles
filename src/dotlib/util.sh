__dotlib::util::has_cmd() {
    type $1 2>&1 1>/dev/null
    test $? = 0
}
