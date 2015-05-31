From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 31 May 2015 12:01:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (atxp1) Drop FSF mailing address
Message-Id: <20150531140139.1020be3c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432931265-21499-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1432931265-21499-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 May 2015 13:27:44 -0700, Guenter Roeck wrote:
> The FSF mailing address may change and does not provide any real value.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/atxp1.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
> index 4c829bb2f9db..78edc56b59e5 100644
> --- a/drivers/hwmon/atxp1.c
> +++ b/drivers/hwmon/atxp1.c
> @@ -11,11 +11,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> - *
>   */
>  
>  #include <linux/kernel.h>

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
