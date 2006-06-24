From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sat, 24 Jun 2006 22:47:04 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060624224704.GA32104@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Sat, Jun 24, 2006 at 02:30:06PM +0200, Rudolf Marek wrote:
> Hello Axel,
> 
> I'm attaching a script that creates snapshots from SVN. It seems there is no
> crontab available on the server, so I'm asking you kindly to run it somewhere.
> 
> The script is fairly simple, it just needs to know the target dir, plus the dir
> where will be the script/temp repo placed. Check first few lines of script please
> 
> It may be executed with lm-sensors or i2c as parameter. We would like to have
> daily snapshots for lm-sensors and weekly for i2c if possible.

OK. Would it perhaps make sense to have tarballs on demand? I'm doing
this for ivtv and you get the tarballs for possible branches (and even
tags aka releases) for free, too.

> I tested the script briefly and it seems to work.
> 
> Thanks,
> Rudolf

> #!/bin/bash
> #
> #  Create a snapshot copy of lm-sensors Nightly Build 
> #  http://zeo.unic.net.my/notes/nightly-build-script/
> #
> #  Modified by Rudolf Marek
> #
> #  Based on:
> #  (CC) 2006 Safirul Alredha.
> 
> # Show me the current date
> date=`date +%Y-%m-%d`
> 
> # our SVN server
> WHICH="$1"
> SVN="http://lm-sensors.org/svn/$WHICH/trunk"
> WWW="/var/www/assembler.cz/$WHICH"
> REPODIR="/home/ruik/buildsnap"
> 
> if [ $# != "1" ]; then
>     echo "Use with: i2c or lm-sensors as param"
>     exit 255;
> fi
> 
> 
> # Change to working space directory. This where all the magic happens.
> cd "$REPODIR"
> if [ ! -d "$WHICH" ] ; then
>     echo "Creating files for first usage"
>     mkdir -p $WWW
>     svn co "$SVN" "$WHICH"
>     echo "0" > "$WWW/LATEST-IS-r0"
> fi 
> 
> # update local copies
> svn update "$WHICH"	
> 
> OLD=`cat "$WWW/LATEST-IS-r"*`
> NEW=`svn info "$WHICH" | grep -r Revision | cut -f 2 -d " "`
> 
> #no need to update
> if [ "$NEW" -le "$OLD" ] ; then
>     exit 0;
> fi
> 
> # create another local copies
> cp -r "$WHICH" "$WHICH"-tmp
> 	
> # Recursively remove all .svn directories from folder k2
> find "$WHICH"-tmp -name .svn -print0 | xargs -0 rm -rf
> 
> # Create archive
> tar czf "$WWW/$WHICH-r$NEW-$date.tar.gz" "$WHICH"/
> 
> rm "$WWW/LATEST-IS-r"*
> echo "$NEW" > "$WWW/LATEST-IS-r$NEW"
> 
> # Dumping svn commit log
> svn log -v "$WHICH" > "$WWW/CHANGELOG"
> 
> # Delete folder
> rm -rf "$WHICH-tmp"

> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060625/f8171a17/attachment.bin 
