#include "../include/StringDataSink.h"

const std::string &CStringDataSink::String() const{
    return DString;
}

bool CStringDataSink::Put(const char &ch) noexcept{
    DString.push_back(ch);
    return true;
}

bool CStringDataSink::Write(const std::vector<char> &buf) noexcept{
    if (!buf.empty()) {
        for (char ch: buf) {
            DString.push_back(ch);
        }
    }
    return true;
}
