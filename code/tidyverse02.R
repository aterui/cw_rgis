
# ggplot

pacman::p_load(tidyverse)

iris


## point figure/scatter plot(?)
ggplot(data = iris, 
       mapping = aes(x = Sepal.Length, 
                     y = Sepal.Width))
# ^result: a working code w/no figure (baseline figure)
ggplot(data = iris, 
       mapping = aes(x = Sepal.Length, 
                     y = Sepal.Width)) + 
  geom_point()
# ^result: we added a layer to our baseline
g_point <- ggplot(data = iris, 
       mapping = aes(x = Sepal.Length, 
                     y = Sepal.Width)) + 
  geom_point()
g_point

# with pipe
g_point <- iris %>% 
  ggplot(aes(x = Sepal.Length,
             y = Sepal.Width)) + 
  geom_point()
g_point

# color by group
iris %>% 
  ggplot(aes(x = Sepal.Length,
             y = Sepal.Width,
             color = Species)) +
  geom_point()
g_point_col <-iris %>% 
  ggplot(aes(x = Sepal.Length,
             y = Sepal.Width,
             color = Species)) +
  geom_point()
g_point_col

# pitfall (common mistake)
iris %>% 
  ggplot(aes(x = Sepal.Length,
             y = Sepal.Width),
             color = Species) +
  geom_point()
iris %>% 
  ggplot(aes(x = Sepal.Length,
             y = Sepal.Width)) +
  geom_point(color = "pink")
iris %>% 
  ggplot(aes(x = Sepal.Length,
             y = Sepal.Width)) +
  geom_point(color = "tomato")
iris %>% 
  ggplot(aes(x = Sepal.Length,
             y = Sepal.Width)) +
  geom_point(color = "magenta")

# line
tibble(x = 1:50,
       y = 2 * x)
df0 <- tibble(x = 1:50,
              y = 2 * x)
df0
df0 %>% 
  ggplot(aes(x = x,
             y = y))
# ^unspecified code
df0 %>% 
  ggplot(aes(x = x,
             y = y)) +
  geom_line()
df0 %>% 
  ggplot(aes(x = x,
             y = y)) +
  geom_line() +
  geom_point()
# histogram
iris %>% 
  ggplot(aes(x = Sepal.Length)) +
  geom_histogram()
iris %>% 
  ggplot(aes(x = Sepal.Length)) +
  geom_histogram()

#box plot
iris %>% 
  ggplot(aes(x = Species,
             y = Sepal.Length)) +
  geom_boxplot()
#change fill
iris %>% 
  ggplot(aes(x = Species,
             y = Sepal.Length,
             color = Species)) +
  geom_boxplot()
iris %>% 
  ggplot(aes(x = Species,
             y = Sepal.Length,
             fill = Species)) +
  geom_boxplot()

#exercise
iris %>% 
  ggplot(aes(x = Petal.Width,
             y = Petal.Length)) +
  geom_point()
g_petal <- iris %>% 
  ggplot(aes(x = Petal.Width,
             y = Petal.Length)) +
  geom_point()
g_petal

g_petal_box <- iris %>% 
  ggplot(aes(x = Species,
             y = Petal.Length,
             fill = Species)) +
  geom_boxplot()
g_petal_box

g_petal_box +
  geom_point()

#changing the axis title
g_petal_box +
  labs(x = "Plant species",
       y = "Petal length")

#exercise (test edition)
df_mtcars <- as_tibble(mtcars)

filter(df_mtcars, cyl == 4)

select(df_mtcars, 
       c(mpg, cyl, disp, wt, vs, carb))

df_sub <- df_mtcars %>% 
  filter(cyl > 4) %>% 
  select(mpg, cyl, disp, wt, vs, carb)
df_sub

v_car <- rownames(mtcars)
mtcars
v_car
df_mtcars <- mutate(df_mtcars,
                    car = v_car)
df_mtcars
df_mtcars %>% 
  filter(cyl == 8) %>% 
  arrange(wt)
df_mean <- df_mtcars %>% 
  group_by(gear) %>% 
  summarize(average = mean(wt))
df_mean

df_mtcars %>% 
  ggplot(aes(x = wt,
             y = qsec)) +
  geom_point()
df_mtcars %>% 
  filter(cyl == 6) %>% 
  ggplot(aes(x = wt,
             y = qsec)) +
  geom_point()
df_mtcars %>% 
  filter(cyl == 6) %>% 
  ggplot(aes(x = wt,
             y = qsec)) +
  geom_point()

df_mtcars %>% 
  group_by(gear) %>% 
  summarize(average1 = mean(wt),
            average2 = mean(qsec)) %>% 
  ggplot(aes(x = average1,
             y = average2)) +
  geom_point() +
  labs(x = "mu_wt",
       y = "mu_qsec")
