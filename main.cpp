#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QStandardPaths>
#include <QSqlDatabase>
#include <QSqlError>
#include <QQuickStyle>
#include <QtQml>

#include "SqlBackend/sqlcontactmodel.h"
#include "SqlBackend/sqlconversationmodel.h"


static void connectToDatabase(){
    QSqlDatabase database = QSqlDatabase::database();
    if(!database.isValid()){
        database = QSqlDatabase::addDatabase("QSQLITE");
        if(!database.isValid())
            qFatal("Cannot add database: %s", qPrintable(database.lastError().text()));
    }

    const QDir writeDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    if(!writeDir.mkpath("."))
    {
        qFatal("Failed to Create writeable directory at %s", qPrintable(writeDir.absolutePath()));
    }
    const QString fileName = writeDir.absolutePath() + "/chat-database.sqlite3";
    // When using the SQLite driver, open() will create the SQLite database if it doesn't exist.
    database.setDatabaseName(fileName);
    if (!database.open()) {
        qFatal("Cannot open database: %s", qPrintable(database.lastError().text()));
        QFile::remove(fileName);
    }
    else
    {
        qDebug() << fileName;
    }

}


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Universal");

    qmlRegisterType<SqlContactModel>("MySqlModel", 1, 0, "SqlContactModel");
    qmlRegisterType<SqlConversationModel>("MyConversationModel", 1, 0, "SqlConversationModel");

    connectToDatabase();

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QObject::connect(&engine, &QQmlApplicationEngine::quit, &QGuiApplication::quit);
    engine.load(url);

    return app.exec();
}
