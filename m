From: patyoung13@hotmail.com (Pat Young)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: No sensors found. Ticket: 1939
Message-Id: <BAY102-F176003FCB60360C0670476C2400@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY102-F20217FD8020B37144FE5CCC2400@phx.gbl>
In-Reply-To: <BAY102-F20217FD8020B37144FE5CCC2400@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

Thank you for the response.  To be honest I really just want to be able to 
run gkrellm and get cpu temp.  If the best way to do so is to patch the 
kernel source then yes that's what I'd like to do.  Unfortunately as I said 
before I am new to it.  I'm running Redhat Enterprise 4.  I don't seem to 
have the directory that you refer to: usr/src/linux-2.6.12-rc1.  In /usr/src 
I have:

/redhat
/kernels

I think I may be in over my head....  Is the file that I downloaded going to 
work or am I out of luck?

Thanks,

Pat

From: Grant Coady &lt;grant_nospam@dodo.com.au&gt;
To: &quot;Pat Young&quot; &lt;patyoung13@hotmail.com&gt;
CC: lm78@Stimpy.netroedge.com
Subject: Re: No sensors found. Ticket: 1939
Date: Thu, 24 Mar 2005 13:55:57 +1100

Hi Pat,
usr/src/linux-2.6.12-rc1
On Wed, 23 Mar 2005 18:39:02 -0800, &quot;Pat Young&quot; 
&lt;patyoung13@hotmail.com&gt; wrote:

&gt;I have downloaded the patch but must admit I am new to the use of the 
patch
&gt;command.  I have read the man page and am not sure as to what the 
-p&lt;num&gt;
&gt;should be.  I receive the following:

You want to apply a patch to the kernel source?

cd /usr/src/linux-2.6.12-rc1
cat linux-2.6.12-rc1-i2c-w83627ehf-rc1.diff | patch -p1

is the standard place from which to apply patches to kernel source

Cheers,
Grant.

