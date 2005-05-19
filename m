From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <3FCBF378.476899D1@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
>
> One additional note. In sensors-detect we scan all addresses from 0x00
> to 0x7F. I don't think it's correct. According to what I know, 0x00,
> 0x02-0x03, 0x0C and 0x7C-0x7F should not be scanned, being respectively
> the general call address, a reserved range, the alert response address
> and another reserved range. I propose to exclude these addresses from
> the scan. Then, all we need to do is add four addresses to the exclusion
> list if an IBM system is detected. This also opens a path for more
> addresses exclusions if this is needed later.
> 
> Comments welcome.


agreed. this used to be on my to-do list.
i2c-core scans all addressess too which is even worse
than having userspace do it.

Actually it's not that bad to scan all the adresses, 
it's just bad to probe them all with
each of the driver tests.

the worst one is 0x00. The others shouldn't really be a problem, I don't
think.
