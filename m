From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 24 Jun 2006 20:56:28 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060624225628.fc766e49.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> I'm attaching a script that creates snapshots from SVN. It seems there is no
> crontab available on the server, so I'm asking you kindly to run it somewhere.
> 
> The script is fairly simple, it just needs to know the target dir, plus the dir
> where will be the script/temp repo placed. Check first few lines of script please
> 
> It may be executed with lm-sensors or i2c as parameter. We would like to have
> daily snapshots for lm-sensors and weekly for i2c if possible.
> 
> I tested the script briefly and it seems to work.

Thanks for working on this. We had this feature on the old lm-sensors
site and it was very convenient for some users, so it would be nice to
have it on the new site too.

I think the following part of your script can be improved:

> # create another local copies
> cp -r "$WHICH" "$WHICH"-tmp
> 	
> # Recursively remove all .svn directories from folder k2
> find "$WHICH"-tmp -name .svn -print0 | xargs -0 rm -rf
> 
> # Create archive
> tar czf "$WWW/$WHICH-r$NEW-$date.tar.gz" "$WHICH"/

First of all I guess you really meant "$WHICH"-tmp on the last line, or
you will be archiving the copy which still has the .svn directories.
But even then, this isn't really efficient, neither as disk space nor
as processing time is concerned. Instead, you could tell tar not to
pick the .svn directories:

tar czf "$WWW/$WHICH-r$NEW-$date.tar.gz" --exclude .svn "$WHICH"/

So you don't have to duplicate the tree.

Thanks,
-- 
Jean Delvare

