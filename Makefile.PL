use 5.00503;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Tk::DataTree',
  VERSION_FROM => 'lib/Tk/DataTree.pm',
  PREREQ_PM    => { 'Tk'            => 800.021,
                    'Tk::Tree'      => 3.019,
                    'Tk::ItemStyle' => 3.004,
                    'Tk::widgets'   => 3.009,
                    'Scalar::Util'  => 1.01,
                    'XSLoader'      => 0.01,
                  },
  ($] >= 5.005 ?
    (ABSTRACT_FROM  => 'lib/Tk/DataTree.pm',
     AUTHOR         => 'Marcus Holland-Moritz <mhx@cpan.org>') : ()
  ),
);
