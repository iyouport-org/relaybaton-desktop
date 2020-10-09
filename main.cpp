#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QtQuickWidgets/QQuickWidget>
#include "core.h"
#include "config.h"
#include <iostream>

int main(int argc, char *argv[]) {
    Init();
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    qmlRegisterType<config>("org.iyouport.config", 1, 0, "Config");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
            &engine, &QQmlApplicationEngine::objectCreated,
            &app, [url](QObject *obj, const QUrl &objUrl) {
                if (!obj && url == objUrl)
                    QCoreApplication::exit(-1);
            },
            Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}