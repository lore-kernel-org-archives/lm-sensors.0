From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 13 Apr 2014 10:11:06 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (lm77) Drop FSF mailing address
Message-Id: <20140413121106.73800eea@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397322118-4275-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397322118-4275-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 12 Apr 2014 10:01:56 -0700, Guenter Roeck wrote:
> The FSF mailing address changes over time, so drop it.
> 
> No functional change.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm77.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
> index 9e60eea..2e0918e 100644
> --- a/drivers/hwmon/lm77.c
> +++ b/drivers/hwmon/lm77.c
> @@ -19,10 +19,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
>  #include <linux/module.h>

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
