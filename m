From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Mar 2007 14:21:04 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <20070311152104.bd092ff9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 11 Mar 2007 10:17:18 -0400, Hans de Goede wrote:
> True, I've already poked one of the students who has written the dynamic 
> features support patches to get moving with regards to merging them. However 
> this was a semester project and the semester is over. So I don't know how this 
> will fare. If he doesn't get moving soon I'll jump in and start posting them 
> for review and make the necessary fixes myself.
> 
> That still leaves the question where to put these patches. I myself don't 
> really like the whole grand 3.0 scheme, because we are all really busy with 
> other stuff and IMHO don't seem to have the manpower todo a whole new release, 
> and also I don't see any improvements planned to warrant this version jump and 
> more important to break ABI compatibility. libsensors API is not ideal, if we 
> are going to break the API + ABI, then I would like to first see a redesign of 
> said API. So I would rather see small incremental steps. For example putting 
> dyn features detect in 2.10.x (or 2.12.0), but at first only for new chips, 
> then check with 2.6 only chips, and remove those one at a time from the static 
> list. An other small increment could be adding include directive support to 
> sensors.conf. An other incremenuld be to put in #ifdef's around 2.4 compat / 
> only code so that people who want to can build a version without 2.4 support.
> 
> Anyways I think I've made my preference clear. If you and Mark prefer doing a 
> 3.0 and putting new features there, then my student or I will start looking at 
> the 3.0 svn branch and adjusting the patches as needed. So let me know what it 
> will be.

I don't really care, libsensors is more or less Mark's realm, I am busy
enough with the kernel side of things. As long as we do not duplicate
the effort in two different branches, I'm fine. Also keep in mind that
the 2.10.x branch _must_ be stable. We must be able to release a new
version any time if there's a need, as is the case for 2.10.3. Going
with a 3.0.x branch makes it possible to make things unstable if it's
easier that way.

-- 
Jean Delvare

