From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: PATCH add locking for set_* access to data-> and chip
Message-Id: <jp6d41197qpo4d3gbhfbc39b47570l2cr6@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1efc41hcg40f2s2mpgc053o5sf689489cq@4ax.com>
In-Reply-To: <1efc41hcg40f2s2mpgc053o5sf689489cq@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 27 Mar 2005 15:01:40 +1000, Grant Coady <grant_nospam@dodo.com.au> wrote:

>Greetings,
>
>Second try, adjusted user-agent for larger attachments.
>
>Most i2c sensor drivers are not protecting access to their 
>local data copy during access by set_some_value writers.  
>
>This patch series adds locking to drivers needing it, and 
>modifies some files with locking to for consistent placement 
>of the down() call to after the sysfs value is read.
>
>Drivers affected:
>adm1021	adm1025 adm1026 adm1031 asb100 ds1621 fscher fscpos 
>gl518sm gl520sm it87 lm63 lm75 lm77 lm78 lm80 lm83 lm85 lm87
>lm90 lm92 max1619 pc87360 pcf8591 sis5595 smsc47m1 via686a 
>w83627hf w83781d

Third round fixes here, too late for me tonight to split, 
send me a script idea, brain stopped... :)

worksheet, gzipp'd bigdiff and W83781D_RT removal patch 
available from with requested changes:

	http://scatter.mine.nu/lmsensors/lock-on-set/

Cheers,
Grant.
