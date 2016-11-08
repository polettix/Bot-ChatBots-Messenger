requires 'perl',             '5.010';
requires 'Bot::ChatBots',    '0.001008';
requires 'namespace::clean', '0.27';

on test => sub {
   requires 'Test::More', '0.88';
   requires 'Path::Tiny', '0.096';
};

on develop => sub {
   requires 'Path::Tiny',        '0.096';
   requires 'Template::Perlish', '1.52';
   requires 'Mojolicious',       '7.10';
};
