#include <QtGui/QApplication>

#include "mainui.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    a.setApplicationName("MyQtApplication");
    a.setQuitOnLastWindowClosed(true);

    mainui w;
    w.setFixedSize(600,570);
    w.show();

    return a.exec();
}
