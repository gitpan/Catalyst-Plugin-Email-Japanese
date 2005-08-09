use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Catalyst::Plugin::Email::Japanese',
    AUTHOR            => 'Daisuke Murase <typester@cpan.org>',
    VERSION_FROM      => 'lib/Catalyst/Plugin/Email/Japanese.pm',
    ABSTRACT_FROM     => 'lib/Catalyst/Plugin/Email/Japanese.pm',
    PREREQ_PM         => {
        Catalyst => '5.30',
        MIME::Lite::TT::Japanese => 0,
    },
);
