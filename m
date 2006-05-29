From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Mon, 29 May 2006 11:24:58 +0000
Subject: [lm-sensors] svn resync
Message-Id: <20060529112458.GI30195@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <44621B6E.6070500@sh.cvut.cz>
In-Reply-To: <44621B6E.6070500@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 29, 2006 at 12:06:12PM +0200, Axel Thimm wrote:
> Hi,
> 
> On Mon, May 29, 2006 at 08:29:48AM +0200, Jean Delvare wrote:
> > Philip Edelbrock wrote:
> > > OK, the tar ball is there in my home directory.  I also removed everyone 
> > > from the writers file at cvs.lm-sensors.nu.
> 
> > Axel, please proceed with the migration. There's one extra thing I'd
> > like you to do if possible. All our cvs commits used to begin with the
> > commiter's short name inside parentheses. This was helping us identify
> > in the commit mail who had been doing the change. Subversion does
> > already include the user name in the mails it generates so this
> > information is now redundant. Can the names be easily removed from the
> > messages during the migration?
> 
> I'll check and see whether I can easily regex this away.

I'm a bit hesitant, look at the simple regex parsing below. Sometimes
it was used for other context, and sometimes even for defering to
another external contributor.

The bulk is Frodo, Khali and mds. Maybe you'd like me to only remove
these or another selected subset? Note also the some *.v files are
binaries like pngs, these should be handled even more carefully. See
also below for a list triggering the matching.

I'd be tempted to not do anything, before creating some inconsistency
that will prop up months later. What do you think?

grep -ra '^@(.*) ' cvs | sed -e's,.*:@(\([^)]*\)) .*,\1,' | sort | uniq -c
     22 amalysh
      1 Aurelien Jarno
      1 Axel Thimm
      7 bobd
      3 bob dougherty
      5 dan
      6 Dan
      9 frodo
   2602 Frodo
      8 Frodo (Frodo
      1 Frodo?ti fix, applied a bit differently (about fan_div and
      1 Frodo?ti fix, applied a bit differently (about fan_div and
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      1 Frodo?ti M?kki's patches
      2 Frodo?ti M?kki's semicolon fix.
      1 frood
     11 khali
   2627 Khali
     13 marius
      1 mariusr
   2651 mds
     10 Merlin
      1 MK
     26 MKN
    186 mmh
    120 Phil
      2 ruik
     44 Ruik
      1 Ruik?dez-Sanguino Pe? <jfs@@computer.org>
     14 simon
      7 Simon
      1 smbus.c
      1 stephen
      1 Stephen

# grep -rE '^@\((Frodo|Khali|mds)\) ' cvs|grep Binary
Binary file cvs/lm_sensors2/archive/Attic/mod-19981006.tar.gz,v matches
Binary file cvs/lm_sensors2/archive/Attic/mod-19990118.tar.gz,v matches
Binary file cvs/website/archive/lm78-1.0p2.tgz,v matches
Binary file cvs/website/archive/lm78-1.0p4.tgz,v matches
Binary file cvs/website/archive/lm78-1.2.1.tgz,v matches
Binary file cvs/website/linux-magazin/klm_error.gif,v matches
Binary file cvs/website/linux-magazin/klm_sensors2.gif,v matches
Binary file cvs/website/linux-magazin/lm_sensors.gif,v matches
Binary file cvs/website/linux-magazin/lm_sensors_s.gif,v matches
Binary file cvs/website/linux-magazin/sensors.png,v matches
Binary file cvs/website/linux-magazin/temp_beast.gif,v matches
Binary file cvs/website/decode-dimms.html,v matches
Binary file cvs/website/lm78.jpg,v matches
Binary file cvs/website/tempall.png,v matches
Binary file cvs/website/Attic/osi-logo.gif,v matches
Binary file cvs/website/layers.gif,v matches
Binary file cvs/website/osi-certified-120x100-t.png,v matches

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060529/c9723429/attachment.bin
