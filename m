From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 24 Jun 2006 22:23:55 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <449DBB7B.70109@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
> Thanks for working on this. We had this feature on the old lm-sensors
> site and it was very convenient for some users, so it would be nice to
> have it on the new site too.

It did not took too long -in the magnitude of minutes.

> I think the following part of your script can be improved:
> 
>> # create another local copies
>> cp -r "$WHICH" "$WHICH"-tmp
>> 	
>> # Recursively remove all .svn directories from folder k2
>> find "$WHICH"-tmp -name .svn -print0 | xargs -0 rm -rf
>>
>> # Create archive
>> tar czf "$WWW/$WHICH-r$NEW-$date.tar.gz" "$WHICH"/
> 
> First of all I guess you really meant "$WHICH"-tmp on the last line, or
> you will be archiving the copy which still has the .svn directories.
> But even then, this isn't really efficient, neither as disk space nor
> as processing time is concerned. Instead, you could tell tar not to
> pick the .svn directories:
> 
> tar czf "$WWW/$WHICH-r$NEW-$date.tar.gz" --exclude .svn "$WHICH"/

Yes you are correct. This part was based on original script and I was lazy to
change it. And made the mistake ;) I will try to fix it tomorrow/today. I think
there was already a midnight here...

Regards
Rudolf

