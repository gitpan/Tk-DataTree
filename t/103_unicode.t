################################################################################
#
# $Project: /Tk-DataTree $
# $Author: mhx $
# $Date: 2008/01/11 00:18:49 +0100 $
# $Revision: 2 $
# $Snapshot: /Tk-DataTree/0.05 $
# $Source: /t/103_unicode.t $
#
################################################################################
#
# Copyright (c) 2004-2008 Marcus Holland-Moritz. All rights reserved.
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
################################################################################

use Test;
BEGIN { plan tests => 1 }

use Tk;
use Tk::DataTree;

my $sleep = $ENV{DATATREE_TEST_SLEEP} || 0;

my $mw = new MainWindow;
$mw->geometry("480x320");

my $dt = $mw->DataTree(-typename => "test", -activecolor => 'blue')
            ->pack(-fill => 'both', -expand => 1);

$mw->idletasks;

require Encode;

if ($@) {
  skip('skip: Encode not installed', 0, 0);
}
else {
  my $alpha = Encode::decode('UCS2-BE', pack('n*', 913, 955, 960, 952, 945));
  my $omega = Encode::decode('UCS2-BE', pack('n*', 937, 956, 949, 947, 945));
  my $foo = Encode::decode('UCS2-BE', pack('n*', 0x20ac, 0x00a5, 0x00c6));

  $dt->data( { $alpha => { $omega => [ $foo ] } } );
  $mw->idletasks;

  ok($@,'');
  select undef, undef, undef, $sleep;
}
