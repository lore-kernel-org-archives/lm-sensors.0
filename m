From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: tickets needing help
Message-Id: <3FF6F4AD.9080303@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF64825.9060808@verizon.net>
In-Reply-To: <3FF64825.9060808@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
>>1499 - i2c-sis645 renamed to i2c-sis96x in kernel 2.6, any way we can
>>handle this in sensors-detect? Khali or other perl guy?
>>
>>1503 - i2c_get_client() function in 2.4 kernels - Khali?
>>
>>1506 - asb100 detection - Mark?
> 
> 
> I am the only one thinking that this ticket system should be canceled?
> I don't think anyone but MDS reads then regularly. Half of the time we
> would need more information but don't hear back from the posters,
> leaving the ticket opened for months. Or the discussions ends up on the
> mailing-list. I think it would be much easier for everyone that we close
> the tickets system (well, leave the existing ones in place for research
> purposes, but do not allow for newer tickets) and direct the users to
> the mailing list. This might be the time for a more "professional" list
> (I'm of course refering to the technical aspect, not the quality of
> support ;)) so that Phil doesn't have to handle subscriptions by
> himself.
> 

disagree. 

- tickets don't get forgotten or overlooked
- tickets are a real database that we control, easily searchable using tools we control
  (as opposed to relying on google for the mail archive)
- searchable tickets allows users to help themselves and reduces traffic on mailing list
- having a real bug tracking system is the essence of a "professional" project

Our ticket system has problems (need more of us using it, need a method for followups);
maybe something else would be better, but email-only is a big step backwards.

mds

