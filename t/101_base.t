################################################################################
#
# $Project: /Tk-DataTree $
# $Author: mhx $
# $Date: 2004/03/30 18:26:19 +0200 $
# $Revision: 3 $
# $Snapshot: /Tk-DataTree/0.01 $
# $Source: /t/101_base.t $
#
################################################################################
#
# Copyright (c) 2004 Marcus Holland-Moritz. All rights reserved.
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
################################################################################

use Test;
BEGIN { plan tests => 35 }

use Tk;
use Tk::DataTree;
use Scalar::Util qw(dualvar);

my $sleep = $ENV{DATATREE_TEST_SLEEP} || 0;

my $mw = new MainWindow;
$mw->geometry("480x320");

my $dt = $mw->DataTree(-typename => "my_type", -activecolor => 'blue')
            ->pack(-fill => 'both', -expand => 1);

$mw->idletasks;

while( <DATA> ) {
  s/^\s*#.*//;
  /\S/ or next;
  eval $_;
  $mw->idletasks;
  ok($@,'');
  select undef, undef, undef, $sleep;
}

__DATA__

$dt->update( { foo => { bar => [ 1 ] } } );

$dt->update( undef );
$dt->configure(-typename => 'typeA');
$dt->update( 'foo' );
$dt->configure(-typename => 'typeB');
$dt->update( 123 );
$dt->configure(-typename => 'typeC');
$dt->update( 3.14159 );

$dt->update( { foo => { bar => [ 1 ] } } );
$dt->update( { foo => { bar => [ 1, 2 ] } } );
$dt->update( { foo => { bar => [ 1, 2, 3 ] } } );
$dt->update( { foo => { bar => [ 1, 2, 3 ] }, xyz => 123 } );

$dt->update( { foo => { bar => [ 1, 2, 3 ], baz => "xxx" }, xyz => 123 } );
$dt->update( { foo => { bar => [ 1, 3, 3 ], baz => "xxx" }, xyz => 123 } );
$dt->update( { foo => { bar => [ 1, 3, 3 ], baz => "xx" }, xyz => 123 } );
$dt->update( { foo => { bar => [ 1, 3, 3 ], baz => "xx" }, xyz => 42 } );
$dt->update( { foo => { bar => [ 1, 2, 3 ], baz => "xxx" }, xyz => 123 } );
$dt->update( { foo => { bar => [ 1, 2, 3 ], baz => "xxx" }, xyz => 123 } );

$dt->configure(-activecolor => '#00A000', -typename => 'foobar');

$dt->update( { foo => { bar => [ 1, 2, 3 ], baz => "xxx" }, xyz => dualvar(123, 'Hello') } );
$dt->update( { foo => { bar => [ 1, 2, 3 ], baz => "xxx" }, xyz => dualvar(123, 'World') } );
$dt->update( { foo => { bar => [ 1, 2, 3 ], baz => "xxx" }, xyz => dualvar(456, 'World') } );
$dt->update( { foo => { bar => [ 1, 2, 3 ], baz => "xxx" }, xyz => 'World' } );
$dt->update( { foo => { bar => [ 1, [2, 3], {four => 4, five => 5} ], baz => "xxx" }, xyz => 123 } );

$dt->configure(-activecolor => '#A000A0');

$dt->update( { foo => { bar => [ 1, [2], {four => 4} ], baz => "xxx" }, xyz => 123 } );
$dt->update( { foo => { bar => [ 1, [2], {four => 4} ] }, xyz => 123 } );
$dt->update( { foo => { bar => [ 1, [2], {four => 4} ] } } );
$dt->update( { foo => { bar => [ 1, [2] ] } } );
$dt->update( { foo => { bar => [ 1 ] } } );

$dt->update( { foo => { bar => [ 1, undef ] } } );
$dt->update( { foo => { bar => [ 1, undef ] }, baz => undef } );

$dt->configure(-undefcolor => '#A0A000');

$dt->update( { foo => { bar => [ 1 ] }, baz => undef } );
$dt->update( { baz => undef } );

