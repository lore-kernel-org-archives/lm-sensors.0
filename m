From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: CVS tests report
Message-Id: <3EE15EE4.9070500@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030606183514.2e884183.khali@linux-fr.org>
In-Reply-To: <20030606183514.2e884183.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

That's definitely it.
i2c_register_entry() in lk2-4 doesn't kmalloc and copy the client's ctl_table_template.
So the sysctl table is all messed up.
The HEAD branch looks much closer to correct.
But the CVS log shows merges by Kyosti from 2.5 back to 2.4 so not quite sure
yet what went wrong.
I'll work on it tomorrow.
BTW when you rmmod i2c-proc right now, it doesn't completely remove
the sysctl table, and things really go bad.
I'm doing lots of diffs to figure out what to do next and hope to get things into shape tomorrow.
mds

Mark D. Studebaker wrote:
> Great catch on the eeprom problem.
> I duplicated it here.
> i2cdump returns the correct values.
> However all eeprom directories in /proc/sys/dev/sensors contain
> the same values (I have eeproms at 50,51,52 and all the values
> are from the chip at 52).
> 
> I wonder if the problem is in i2c_register_entry() in i2c-proc.c.
> The function was rewritten between 2.7.0 and the branch, then
> rewritten again after the branch in the HEAD branch.
> I tried the i2c-proc from the HEAD branch but it oopsed
> in i2c_register_entry().
> 
> I'll keep looking. Anybody with ideas speak up.
> 
> Jean Delvare wrote:
> 
>> Hi,
