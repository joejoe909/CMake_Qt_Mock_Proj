#include "MainWindow.h"
#include "ui_MainWindow.h"

#include <QString>

MainWindow::MainWindow(QWidget* parent)
    : QMainWindow(parent),
      ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    loadData();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::loadData()
{
    QString text;

    text += "Names:\n";
    for (const auto& name : m_dataStore.names()) {
        text += " - " + name + "\n";
    }

    text += "\nValues:\n";
    for (const auto value : m_dataStore.values()) {
        text += " - " + QString::number(value) + "\n";
    }

    text += "\nScores:\n";
    for (const auto& [subject, score] : m_dataStore.scores()) {
        text += " - " + subject + ": " + QString::number(score) + "\n";
    }

    ui->textEdit->setText(text);
}