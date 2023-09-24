/// Project convention:
/// A - domain object
/// B - data transfer object
abstract interface class BiDirectionalDataMapper<A, B> {
  A from(B data);

  B to(A data);
}
