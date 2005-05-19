From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: No sensors found. Ticket: 1939
Message-Id: <ira4415d6fhuuumu15rjkfcggirv6pp2mu@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY102-F20217FD8020B37144FE5CCC2400@phx.gbl>
In-Reply-To: <BAY102-F20217FD8020B37144FE5CCC2400@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Pat,

On Wed, 23 Mar 2005 18:39:02 -0800, "Pat Young" <patyoung13@hotmail.com> wrote:

>I have downloaded the patch but must admit I am new to the use of the patch 
>command.  I have read the man page and am not sure as to what the -p<num> 
>should be.  I receive the following:

You want to apply a patch to the kernel source?

cd /usr/src/linux-2.6.12-rc1
cat linux-2.6.12-rc1-i2c-w83627ehf-rc1.diff | patch -p1

is the standard place from which to apply patches to kernel source

Cheers,
Grant.
