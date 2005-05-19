From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: RFC: vid scaling does not belong in kernel?
Message-Id: <f1b6519vsat0vbs8uq13mon6frmn8k9qop@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
In-Reply-To: <14b451tlic7clc0rgn5aquvd4iqa7mre55@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, All,

On Tue, 5 Apr 2005 21:23:08 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> So I don't have vrm, therfore I don't need to scale vid, that's the 
>> logical reduction I've been trying to reach.  Why am I scaling a
>> value when nothing can write access vrm?
>
>You do have VRM, it is only auto-detected from the CPU model instead of
>being set by the user. You still need to convert {VID, VRM} into a
>voltage value.
>
s/scaling/mapping/ sorry, I knew what I meant :)  So what I have missed 
is the connection to this auto-cpu-detect value for vrm.  During last 
query on this some weeks? ago I was told make it settable from user-space, 
now it seems that is wrong track.  I'll survey drivers using it and see 
if I can work it out.  That's why I did the cross-reference stuff in first 
place, see which driver uses what to cherry-pick possible solutions. 

Cheers,
Grant.
