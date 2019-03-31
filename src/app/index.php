<?php
use Swoole\Coroutine as co;
$id = go(function(){
    $id = co::getUid();
    echo "start coro $id\n";
    co::suspend();
    echo "resume coro $id @1\n";
    co::suspend();
    echo "resume coro $id @2\n";
});
echo "start to resume $id @1\n";
co::resume($id);
echo "start to resume $id @2\n";
co::resume($id);
echo "main\n";
sleep(100);

return;
$http = new swoole_http_server('0.0.0.0', 8101);

$http->set([
    'worker_num' => 4, // The number of worker processes
    'daemonize' => true, // Whether start as a daemon process
    'backlog' => 128, // TCP backlog connection number
]);

$http->on("start", function ($server) {
    echo "Swoole http server is started at http://127.0.0.1:8101\n";
});

$http->on("request", function ($request, $response) {
    // sleep(5);
    $response->header("Content-Type", "text/plain");
    $response->end("Hello World!\n");
});

$http->start();

