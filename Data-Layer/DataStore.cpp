#include "DataStore.h"

DataStore::DataStore()
{
    m_names = { "Alice", "Bob", "Charlie" };
    m_values = { 10, 20, 30 };

    m_scores = {
        { "Math", 95 },
        { "Science", 88 },
        { "Programming", 100 }
    };
}

const std::vector<QString>& DataStore::names() const
{
    return m_names;
}

const std::vector<int>& DataStore::values() const
{
    return m_values;
}

const std::map<QString, int>& DataStore::scores() const
{
    return m_scores;
}