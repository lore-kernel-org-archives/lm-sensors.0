From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 15 May 2006 16:47:45 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <20060515184745.bfea03cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Trying to build against 2.6.16.16, I ran into undefined references to 
> SENSOR_ATTR arrays. After a quick search it looks like it was introduced 
> little time ago.
> 
> Do I need to upgrade to 2.6.17-rc4 or is there another separate patch to 
> apply ?

That would be this patch:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;hBd3b83fecb7b576d477244347982baa02fa4f44

Now I can't promise that it'll be enough.

-- 
Jean Delvare

