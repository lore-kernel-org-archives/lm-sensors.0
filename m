From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: LM93 vccp_limit_type "relative" does not work
Message-Id: <417046B9.3080703@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <416EDF3D.7090307@earthlink.net>
In-Reply-To: <416EDF3D.7090307@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi David:
> 
> * Mark M. Hoffman <mhoffman@lightlink.com> [2004-10-14 22:58:18 -0400]:
> 
>>* David Knierim <david_knierim@earthlink.net> [2004-10-14 16:19:09 -0400]:
>>
>>>On my box, the register 0xed has the dynamic vccp limit masked out when 
>>>the box boots up.  Loading the driver makes no difference, so step #2 
>>>does not appear to be being done.
>>
>>Oops, that's a bug.
> 
> 
> Also, #VRDHOT errors were masked by default - not sure if you had tested
> that yet.  I fixed it as well in the same CVS commit.
> 
> Regards,
> 

Mark,
    Thanks for the fast turn around.   I'm very impressed.   The 
alarming didn't work right, but I figured out what was wrong.   The 
attached patch fixes it and adds messages if the read retry counts are 
exceeded.

David Knierim

--- kernel/chips/lm93.c.orig	2004-10-15 14:35:06.000000000 -0400
+++ kernel/chips/lm93.c	2004-10-15 14:37:43.000000000 -0400
@@ -382,6 +382,7 @@
  	}

  	/* <TODO> what to return in case of error? */
+	printk(KERN_ERR "lm93.o: All read byte retries failed!!\n");
  	return 0;
  }

@@ -416,6 +417,7 @@
  	}

  	/* <TODO> what to return in case of error? */
+	printk(KERN_ERR "lm93.o: All read word retries failed!!\n");
  	return 0;
  }

@@ -849,12 +851,12 @@
  	result  = b1.host_status_2 & 0x3f;

  	if (vccp_limit_type[0])
-		result |= (b1.host_status_1 & 0x10) << 2;
+		result |= (b1.host_status_4 & 0x10) << 2;
  	else
  		result |= b1.host_status_2 & 0x40;

  	if (vccp_limit_type[1])
-		result |= (b1.host_status_1 & 0x20) << 2;
+		result |= (b1.host_status_4 & 0x20) << 2;
  	else
  		result |= b1.host_status_2 & 0x80
