################################################################################
#
# $Project: /Tk-DataTree $
# $Author: mhx $
# $Date: 2004/03/30 18:26:19 +0200 $
# $Revision: 3 $
# $Snapshot: /Tk-DataTree/0.01 $
# $Source: /t/102_stress.t $
#
################################################################################
#
# Copyright (c) 2004 Marcus Holland-Moritz. All rights reserved.
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
################################################################################

use Test;
BEGIN { plan tests => 100 }

use Tk;
use Tk::DataTree;
use Scalar::Util qw(dualvar);

my $sleep = $ENV{DATATREE_TEST_SLEEP} || 0;

my $mw = new MainWindow;
$mw->geometry("480x600");

my $dt = $mw->DataTree->pack( -fill => 'both', -expand => 1 );

srand 0;
my $string = 'aaaaa';

$mw->idletasks;

for (1 .. 100) {
  s/#.*//;
  /\S/ or next;
  my $r = getrand();
  $dt->update($r);
  $dt->configure(-activecolor => getcolor(),
                 -undefcolor  => getcolor());
  $mw->idletasks;
  ok($@,'');
  select undef, undef, undef, $sleep;
}

sub getcolor
{
  my @hex = ('0'..'9', 'A'..'F');
  join '', '#', map { $hex[rand @hex] } 1 .. 6;
}

sub getrand
{
  my $l = shift || 0;

  my $c = rand( $l > 4 ? 5 : 7 );

  if ($c < 1) {
    return int rand 100000;
  }
  elsif ($c < 2) {
    return $string++;
  }
  elsif ($c < 3) {
    return dualvar(int rand 100000, $string++);
  }
  elsif ($c < 4) {
    return sub { log rand shift };
  }
  elsif ($c < 5) {
    return undef;
  }
  elsif ($c < 6) {
    return [ map { getrand($l+1) } 0 .. rand 10 ];
  }
  elsif ($c < 7) {
    return { map { ($string++ => getrand($l+1)) } 0 .. rand 10 };
  }
}

