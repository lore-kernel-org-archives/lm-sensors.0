From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 01 Jun 2005 11:37:26 +0000
Subject: [lm-sensors] W83792 review and testing
Message-Id: <n00r91t4kdo1tio9domm6mhk1jk0bateji@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <429D7565.4090203@sh.cvut.cz>
In-Reply-To: <429D7565.4090203@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 01 Jun 2005 10:44:21 +0200, Rudolf Marek <r.marek@sh.cvut.cz> wrote:

>Hi all,
>
>I created the patch for 2.6.x kernels with Makefile Kconfig and documentation.
...
>or even any other 2.6 kernel. As long it does not say HUNK failed than it is OK.
Does not compile on 2.6.12-rc5-mm1 due to sysfs changes, was 
going to create patchset but I got distracted with 2.4.31 
coming out today. 

>Rest of people here please help me with documentation review.
Wish I could, chicken & egg --> me waiting for doc review too.
Cannot test the driver itself anyway :(

--Grant.

