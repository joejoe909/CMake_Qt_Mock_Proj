#pragma once

#include <QString>
#include <vector>
#include <map>

class DataStore
{
public:
    DataStore();

    const std::vector<QString>& names() const;
    const std::vector<int>& values() const;
    const std::map<QString, int>& scores() const;

private:
    std::vector<QString> m_names;
    std::vector<int> m_values;
    std::map<QString, int> m_scores;
};