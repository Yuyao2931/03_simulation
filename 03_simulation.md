03_simulation
================
Yuyao
2026-11-10

``` r
library(tidyverse)

source("sim_mean_sd.R")

set.seed(1236)
```

``` r
output = vector("list", length = 1000)

for (i in 1:1000) {
  
  output[[i]] 
}
```

let’s do this using tibbles and map instead!

``` r
sim_results_df =
  tibble(
    samp_size = rep(30, 1000)
  ) |> 
  mutate(
    est_df = map(samp_size, sim_mean_sd)
  ) |> 
  unnest(est_df)
```

look at results

``` r
sim_results_df |> 
  ggplot(aes(x = mean)) + 
  geom_density()
```

<img src="03_simulation_files/figure-gfm/unnamed-chunk-4-1.png" alt="" width="90%" />

## change `n`

``` r
sim_results_df =
  expand_grid(
    samp_size = c(30, 60, 120, 240),
    iter = 1:1000
  ) |> 
  mutate(
    est_df = map(samp_size, sim_mean_sd)
  ) |> 
  unnest(est_df)
```

``` r
sim_results_df |> 
  mutate(
    samp_size = str_c("n = ", samp_size),
    samp_size = fct_inorder(samp_size)
  ) |> 
  ggplot(aes(x = samp_size, y = mean)) +
  geom_violin()
```

<img src="03_simulation_files/figure-gfm/unnamed-chunk-6-1.png" alt="" width="90%" />

look at the numbers

``` r
sim_results_df |> 
  mutate(
    samp_size = str_c("n = ", samp_size),
    samp_size = fct_inorder(samp_size)
  ) |> 
  group_by(samp_size) |> 
  summarise(
    emp_m = mean(mean),
    emp_se = sd(mean)
  )
```

    ## # A tibble: 4 × 3
    ##   samp_size emp_m emp_se
    ##   <fct>     <dbl>  <dbl>
    ## 1 n = 30     12.0  0.563
    ## 2 n = 60     12.0  0.382
    ## 3 n = 120    12.0  0.279
    ## 4 n = 240    12.0  0.185
