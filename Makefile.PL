use 5.00503;
use ExtUtils::MakeMaker;
use Config qw(%Config);

for (@ARGV) {
  /^-pm/ and $no_xs = 1;
  /^-xs/ and $no_xs = 0;
}

sub write_makefile
{
  WriteMakefile(
    NAME         => 'Tk::DataTree',
    VERSION_FROM => 'lib/Tk/DataTree.pm',
    PREREQ_PM    => { 'Tk'            => 800.021,
                      'Tk::Tree'      => 3.019,
                      'Tk::ItemStyle' => 3.004,
                      'Tk::widgets'   => 3.009,
                    },
    CONFIGURE    => \&configure,
    clean        => { FILES => 'test.c' },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Tk/DataTree.pm',
       AUTHOR         => 'Marcus Holland-Moritz <mhx@cpan.org>') : ()
    ),
  );
}

sub configure
{
  return $no_xs ? { XS => {}, C => [] } : {};
}

write_makefile();

defined $no_xs and exit;

sub no_cc
{
  $no_xs = 1;

  print <<"EDQ";

 I cannot determine if you have a C compiler so I will install
 a perl-only implementation with limited functionality.

 You can however force installation of the XS version with:

    $^X Makefile.PL -xs

EDQ

  write_makefile();
  exit;
}

print "Testing if you have a C compiler\n";

open F, ">test.c" or no_cc();
print F "int main() { return 0; }\n";
close F or no_cc();
system "$Config{make} test$Config{obj_ext}" and no_cc();

