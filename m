From: deant@hawaii.rr.com (Dean Takemori)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Fancontrol (perl) patch
Message-Id: <ABAE4B58-C4E9-11D8-AD74-000A95AF6760@hawaii.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
In-Reply-To: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jun 22, 2004, at 8:48 AM, Jean Delvare wrote:

>> The patch should be backed out.  (The second part of the patch, which
>> removes the $sigtype = shift; is harmless)
>
> Instead, I implemented what James Olin Oden suggested: use a global
> variable to keep track of whether the fans were already restored, or
> not. Please check it out and confirm it works ok.

Well,  Appended to this message is the current version of the
fancontrol script that I am happily using.  It uses POSIX::_exit()
to avoid the double-call to the END block, plus it logs STDOUT and
STDERR to different logfiles.

>> PS.  For anyone who's interested, I have an /etc/init.d/fancontrol
>> start/stop script suitable for Fedora Core 1 for use with this perl
>> script (probably also good for FC2 and recent RedHat type distros)
>
> You can send it to the list and we will include into the CVS tree.

Also appended is an /etc/init.d/fancontrol init script that I'm
using on a Fedora Core 1 based system.  It should work on most
later-version (IE RedHat 9 through FC2) RedHat-based distros.  It
doesn't handle start-when-the-daemon-is-already-running quite
correctly but I haven't gotten around to fixing that yet.

-dean takemori


#!/usr/bin/perl -wT
# $Id: fancontrol,v 1.4 2004/06/23 07:43:50 dean Exp $
#
# Perl script for temperature dependent fan speed control.
#
# Copyright 2004 dean takemori <deant@hawaii.rr.com>
#
# This is a reimplementation in perl of Marius Reiner's bash script for
# fan speed control.  It has advantages in that it can daemonize itself
# and needn't spawn subprocesses for grep, sleep etc.  Much of the 
structure
# of the bash script is preserved to make mirroring changes easier, so
# this is seriously non-idiomatic perl but at the same time it should 
not
# be considered a a direct bash to perl translation.
#
# Usage: fancontrol [CONFIGFILE]
#
# For configuration instructions and warnings please see fancontrol.txt,
# which can be found in the doc/ directory or at the website mentioned
# elsewhere.
#
# This script is derived from Marius Reiner's bash version, so it is
# hereby placed under the GPL.
#
#    Copyright 2003 Marius Reiner <marius.reiner@hdev.de>
#
#    This program is free software; you can redistribute it and/or 
modify
#    it under the terms of the GNU General Public License as published 
by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#

use warnings;
use strict;
use IO::Handle;
use Getopt::Std;
use POSIX;

$ENV{PATH} = "/bin:/usr/bin";

##### Configuration #####
use constant DEBUG => 1;
use constant MAX   => 255;

use constant PIDFILE  => '/var/run/fancontrol.pid';
use constant CONFFILE => '/etc/fancontrol';
use constant LOGFILE  => '/var/log/fancontrol/fancontrol.log';
use constant ERRFILE  => '/var/log/fancontrol/fancontrol.err';

use constant SDIR => '/sys/bus/i2c/devices';
### End Configuration ###

our $interval;
our $pwmo;
our @afcpwm;
our @afctemp;
our @afcfan;
our @afcmaxtemp;
our @afcmintemp;
our @afcminstart;
our @afcminstop;

sub loadconfig($);
sub pwmdisable($);
sub pwmenable($);
sub restorefans();
sub calc(@);
sub UpdateFanSpeeds();
END { restorefans(); }

our $opt_d;
getopts('d');

my $config = shift;
if (defined($config))
   { loadconfig($config); }
else
   { loadconfig(CONFFILE); }

### Daemonize
if ( defined($opt_d) && ($opt_d = 1) )
   {
     my $pid = fork;
     POSIX::_exit(0) if $pid;

     unless (defined($pid))
       { die("Couldn't fork: $!"); }

     open(*STDERR, '>', ERRFILE);
     IO::Handle::autoflush(*STDERR);
     open(*STDOUT, '>>', LOGFILE);
     IO::Handle::autoflush(*STDOUT);

     unless (POSIX::setsid())
       { die("Couldn't open new session: $!"); }

   }

### Pidfile
if (open(FILE, ">" . PIDFILE))
   {
     print(FILE "$$\n");
     close(FILE);
   }
else
   { print(PIDFILE . ": $!\n"); }


### What kind of interface?
our $sysfs = 0;
our $dir = '/proc/sys/dev/sensors';
if (!(-d $dir))
   {
     if (!(-d SDIR))
       { die("No sensors found! (are the necessary modules loaded?) : 
$!\n"); }
     else
       {
         $sysfs = 1;
         $dir = SDIR;
       }
   }

### Trap signals
$SIG{TERM} = \&restorefans;
$SIG{HUP}  = \&restorefans;
$SIG{INT}  = \&restorefans;
$SIG{QUIT} = \&restorefans;

### Enable PWM
print("Enabling PWM on fans...\n");
my $fcvcount = 0;
while ($fcvcount < $#afcpwm+1)
   {
     $pwmo = $afcpwm[$fcvcount];
     unless (pwmenable($pwmo))
       { die("Error enabling PWM on $dir/$pwmo : $!\n"); }
     $fcvcount++;
   }

print("Starting automatic fan control...\n");

while(1)
   {
     UpdateFanSpeeds();
     sleep($interval);
   }

1;

################################################################ 
loadconfig($)
sub loadconfig($)
{
   my $file = shift;

   print("Loading configuration from $file ...\n");

   unless ( (-e $file) && (-r $file) )
     { die("Unable to read config file $file: $!"); }

   open(F, $file);

   our ($interval, $fctemps, $fcfans, $mintemp, $maxtemp, $minstart, 
$minstop);
   while($_ = <F>)
     {
       if ($_ =~ /^\s+$/)                { next; }
       elsif ($_ =~ /^INTERVAL=(.*)$/) { $interval = $1; next; }
       elsif ($_ =~ /^FCTEMPS=(.*)$/)  { $fctemps = $1;  next; }
       elsif ($_ =~ /^FCFANS=(.*)$/)   { $fcfans = $1;   next; }
       elsif ($_ =~ /^MINTEMP=(.*)$/)  { $mintemp = $1;  next; }
       elsif ($_ =~ /^MAXTEMP=(.*)$/)  { $maxtemp = $1;  next; }
       elsif ($_ =~ /^MINSTART=(.*)$/) { $minstart = $1; next; }
       elsif ($_ =~ /^MINSTOP=(.*)$/)  { $minstop = $1;  next; }
     }
   close(F);

   unless (defined($interval))
     { die("Some settings missing ..."); }

   print("\nCommon settings: \n");
   print("  INTERVAL=$interval\n");

   my $fcvcount = 0;
   foreach my $fcv (split(/\s+/, $fctemps))
     {
       ($afcpwm[$fcvcount], $afctemp[$fcvcount]) = split(/=/, $fcv);

       $fcfans   =~ s/^\S*=(\S+)\s*//;  $afcfan[$fcvcount]      = $1;
       $mintemp  =~ s/^\S*=(\S+)\s*//;  $afcmintemp[$fcvcount]  = $1;
       $maxtemp  =~ s/^\S*=(\S+)\s*//;  $afcmaxtemp[$fcvcount]  = $1;
       $minstart =~ s/^\S*=(\S+)\s*//;  $afcminstart[$fcvcount] = $1;
       $minstop  =~ s/^\S*=(\S+)\s*//;  $afcminstop[$fcvcount]  = $1;

       print("\nSettings for $afcpwm[$fcvcount]:\n");
       print("  Depends on $afctemp[$fcvcount]\n");
       print("  Controls $afcfan[$fcvcount]\n");
       print("  MINTEMP  = $afcmintemp[$fcvcount]\n");
       print("  MAXTEMP  = $afcmaxtemp[$fcvcount]\n");
       print("  MINSTART = $afcminstart[$fcvcount]\n");
       print("  MINSTOP  = $afcminstop[$fcvcount]\n");

       $fcvcount++;
     }
}


################################################################ 
pwmdisable($)
sub pwmdisable($)
{
   my $p = shift;

   if ($sysfs = 1)
     {
       if (open(F, ">$dir/$p"))
         {
           print(F MAX . '\n');
           close(F);
         }
       else
         { die("$dir/$p : $!"); }

       my $enable = "$dir/$p/pwm/pwm_enable";
       if (-f $enable)
         {
           if (open(F, ">$enable"))
             {
               print(F '0');
               close(F);
             }
           else
             { die("$dir/$p/pwm/pwm_enable : $!"); }
         }
     }
   else
     {
       if (open(F, ">$dir/$p"))
         {
           print(F MAX . ' 0');
           close(F);
         }
       else
         { die("$dir/$p : $!"); }
     }
   return(1);
}


################################################################# 
pwmenable($)
sub pwmenable($)
{
   my $p = shift;

   if ($sysfs = 1)
     {
       my $enable = "$dir/$p/pwm/pwm_enable";
       if (-f $enable)
         {
           if (open(F, ">$enable"))
             {
               print(F "1\n");
               close(F);
             }
           else
             { die("$dir/$p : $!\n"); }
         }
     }
   else
     {
       if (open(F, ">$dir/$p"))
         {
           print(F MAX . " 1\n");
           close(F);
         }
       else
         { die("$dir/$p : $!\n"); }
     }
   return(1);
}


################################################################ 
restorefans()
sub restorefans()
{
   $SIG{TERM} = 'IGNORE';
   $SIG{HUP}  = 'IGNORE';
   $SIG{INT}  = 'IGNORE';
   $SIG{QUIT} = 'IGNORE';

   print("Aborting, restoring fans...\n");
   my $fcvcount = 0;

   while ( $fcvcount < $#afcpwm+1)
     {
       my $pwmo = $afcpwm[$fcvcount];
       &pwmdisable($afcpwm[$fcvcount]);
       $fcvcount++;
     }
   print("Verify fans have returned to full speed\n");
   POSIX:_exit(-1);
}


############################################################ 
UpdateFanSpeeds()
sub UpdateFanSpeeds()
{
   my $fcvcount = 0;

   while ($fcvcount < $#afcpwm+1)
     {
       my $pwmo  = $afcpwm[$fcvcount];
       my $tsens = $afctemp[$fcvcount];
       my $fan   = $afcfan[$fcvcount];
       my $mint  = $afcmintemp[$fcvcount];
       my $maxt  = $afcmaxtemp[$fcvcount];
       my $minsa = $afcminstart[$fcvcount];
       my $minso = $afcminstop[$fcvcount];

       ### tval
       my $tval = 0;
       if (open(F, "$dir/$tsens"))
         {
           $tval = <F>;
           close(F);
         }
       else
         { die("Error reading temperature from $dir/$tsens"); }
       $tval =~ /([.\d]+)\s*$/;
       $tval = int($1);
       if ($sysfs = 1)
         { $tval /= 1000; }

       ### pwmpval
       my $pwmpval = 0;
       if (open(F, "$dir/$pwmo"))
         {
           $pwmpval = <F>;
           close(F);
         }
       else
         { die("Error reading PWM value from $dir/$pwmo"); }
       ($pwmpval) = split(/\s/, $pwmpval);

       ### fanval
       my $fanval = 0;
       if (open(F, "$dir/$fan"))
         {
           $fanval = <F>;
           close(F);
         }
       else
         { die("Error reading Fan value from $dir/$fan"); }
       $fanval =~ /(\d+)\s$/;
       $fanval = $1;

       ### DEBUG
       if (DEBUG = 1)
         {
           print("pwmo=$pwmo\n");
           print("tsens=$tsens\n");
           print("fan=$fan\n");
           print("mint=$mint\n");
           print("maxt=$maxt\n");
           print("minsa=$minsa\n");
           print("minso=$minso\n");
           print("tval=$tval\n");
           print("pwmpval=$pwmpval\n");
           print("fanval=$fanval\n");
           print("\n");
         }

       my $pwmval;
       if ($tval <= $mint)
         { $pwmval = 0; }
       elsif ($tval >= $maxt)
         { $pwmval = MAX; }
       else
         {
           $pwmval = eval ( ($tval - $mint) / ($maxt - $mint) )**2 ;
           $pwmval *= (255 - $minso);
           $pwmval += $minso;
           $pwmval = int($pwmval);
           if ( ($pwmval = 0) || ($fanval = 0) )
             {
               if (open(F, ">$dir/$pwmo"))
                 {
                   print(F "$minsa\n");
                   close(F);
                 }
               else
                 { die("Error writing PWM value to $dir/$pwmo : $!\n"); }
               sleep 1;
             }
         }

       if (open(F, ">$dir/$pwmo"))
         {
           print(F "$pwmval\n");
           close(F);
         }
       else
         { die("Error writing PWM value to $dir/$pwmo : $!\n"); }

       if (DEBUG = 1)
         { print("new pwmval = $pwmval\n"); }

       $fcvcount++;
     }

}

1;





#!/bin/sh
#
# $Id: fancontrol,v 1.2 2004/05/28 09:39:22 dean Exp $
#
# fancontrol
#
# chkconfig: 2345 90 01
# description: start/stop fancontrol
# pidfile: /var/run/fancontrol.pid
#

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH

# Source function library.
. /etc/rc.d/init.d/functions

FANCONTROL="/usr/local/sbin/fancontrol"
PIDFILE="/var/run/fancontrol.pid"

RETVAL=0

start()
{
   echo -n "Starting fancontrol daemon"
   daemon $FANCONTROL -d
   RETVAL=$?
   [ $RETVAL -eq 0 ] && touch /var/lock/subsys/fancontrol
   echo
}

stop()
{
   echo -n "Stopping fancontrol daemon"
   killproc $FANCONTROL
   RETVAL=$?
   rm -f $PIDFILE
   rm -f /var/lock/subsys/fancontrol
   echo
}

status()
{
   if [ -f $PIDFILE ] ; then
     pid=`cat $PIDFILE`
   else
     echo -n "$FANCONTROL does not appear to be running"
     echo
     exit
   fi

   if [ -n "$pid" ] ; then
     ps -p $pid > /dev/null
     if [ $? ] ; then
       echo -n "$FANCONTROL appears to be running"
     else
       echo -n "$FANCONTROL does not appear to be running"
     fi
     echo
   fi
}

condrestart()
{
   [ -e /var/lock/subsys/fancontrol ] && restart || :
}

if [ ! -x $FANCONTROL ] ; then
   echo "Cannot run $FANCONTROL"
   exit 0
fi

case "$1" in
   start)
     start
     ;;

   stop)
     stop
     ;;

   status)
     status
     ;;

   restart)
     stop
     start
     ;;

   condrestart)
     condrestart
     ;;

   *)
     echo "Usage: /etc/init.d/fancontrol 
{start|stop|status|restart|condrestart}"
     RETVAL=1
esac

exit $RETVAL
