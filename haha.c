
struct Bp
{
    int a;
    int b;
};


void ha(struct Bp *s, struct Bp *s2, struct Bp *s3, struct Bp *s4) {
    s->a = 0;
    s->b = 1;
    s2->a = 0;
    s2->b = 1;
    s3->a = 0;
    s3->b = 1;
}

int main() {
    int a = 1;
    int b = 2;
    struct Bp *p;
    struct Bp *p2;
    struct Bp *p3;
    ha(p, p2, p3, p3);
    int c = a + b + p->a;
    return c;
}