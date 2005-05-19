From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: vid scaling does not belong in kernel?
Message-Id: <20050405212308.5d705c42.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
In-Reply-To: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> So I don't have vrm, therfore I don't need to scale vid, that's the 
> logical reduction I've been trying to reach.  Why am I scaling a
> value when nothing can write access vrm?

You do have VRM, it is only auto-detected from the CPU model instead of
being set by the user. You still need to convert {VID, VRM} into a
voltage value.

And again your use of the term "scalling" here is confusing. What you do
is convert a binary value into a voltage value.

-- 
Jean Delvare
